% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Hãy Vui Mừng Trong Chúa" }
  composer = "Tv. 36"
  tagline = ##f
}

% mã nguồn cho những chức năng chưa hỗ trợ trong phiên bản lilypond hiện tại
% cung cấp bởi cộng đồng lilypond khi gửi email đến lilypond-user@gnu.org
% Đổi kích thước nốt cho bè phụ
notBePhu =
#(define-music-function (font-size music) (number? ly:music?)
   (for-some-music
     (lambda (m)
       (if (music-is-of-type? m 'rhythmic-event)
           (begin
             (set! (ly:music-property m 'tweaks)
                   (cons `(font-size . ,font-size)
                         (ly:music-property m 'tweaks)))
             #t)
           #f))
     music)
   music)

% in số phiên khúc trên mỗi dòng
#(define (add-grob-definition grob-name grob-entry)
     (set! all-grob-descriptions
           (cons ((@@ (lily) completize-grob-entry)
                  (cons grob-name grob-entry))
                 all-grob-descriptions)))

#(add-grob-definition
    'StanzaNumberSpanner
    `((direction . ,LEFT)
      (font-series . bold)
      (padding . 0.5)
      (side-axis . ,X)
      (stencil . ,ly:text-interface::print)
      (X-offset . ,ly:side-position-interface::x-aligned-side)
      (Y-extent . ,grob::always-Y-extent-from-stencil)
      (meta . ((class . Spanner)
               (interfaces . (font-interface
                              side-position-interface
                              stanza-number-interface
                              text-interface))))))

\layout {
    \context {
      \Global
      \grobdescriptions #all-grob-descriptions
    }
    \context {
      \Score
      \remove Stanza_number_align_engraver
      \consists
        #(lambda (context)
           (let ((texts '())
                 (syllables '()))
             (make-engraver
              (acknowledgers
               ((stanza-number-interface engraver grob source-engraver)
                  (set! texts (cons grob texts)))
               ((lyric-syllable-interface engraver grob source-engraver)
                  (set! syllables (cons grob syllables))))
              ((stop-translation-timestep engraver)
                 (for-each
                  (lambda (text)
                    (for-each
                     (lambda (syllable)
                       (ly:pointer-group-interface::add-grob
                        text
                        'side-support-elements
                        syllable))
                     syllables))
                  texts)
                 (set! syllables '())))))
    }
    \context {
      \Lyrics
      \remove Stanza_number_engraver
      \consists
        #(lambda (context)
           (let ((text #f)
                 (last-stanza #f))
             (make-engraver
              ((process-music engraver)
                 (let ((stanza (ly:context-property context 'stanza #f)))
                   (if (and stanza (not (equal? stanza last-stanza)))
                       (let ((column (ly:context-property context
'currentCommandColumn)))
                         (set! last-stanza stanza)
                         (if text
                             (ly:spanner-set-bound! text RIGHT column))
                         (set! text (ly:engraver-make-grob engraver
'StanzaNumberSpanner '()))
                         (ly:grob-set-property! text 'text stanza)
                         (ly:spanner-set-bound! text LEFT column)))))
              ((finalize engraver)
                 (if text
                     (let ((column (ly:context-property context
'currentCommandColumn)))
                       (ly:spanner-set-bound! text RIGHT column)))))))
      \override StanzaNumberSpanner.horizon-padding = 10000
    }
}

stanzaReminderOff =
  \temporary \override StanzaNumberSpanner.after-line-breaking =
     #(lambda (grob)
        ;; Can be replaced with (not (first-broken-spanner? grob)) in 2.23.
        (if (let ((siblings (ly:spanner-broken-into (ly:grob-original grob))))
              (and (pair? siblings)
                   (not (eq? grob (car siblings)))))
            (ly:grob-suicide! grob)))

stanzaReminderOn = \undo \stanzaReminderOff
% kết thúc mã nguồn

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \autoPageBreaksOff
  \partial 4 f8 f16 (g) |
  c,8. c16 f8 g |
  a4 bf8 a |
  g8. d'16 d8 d |
  c4. c8 |
  a d,16 (f) g8 g |
  a4 g8 g |
  d (f4) g8 |
  c,4 r8 g'16 (a) |
  f4 f |
  
  \pageBreak
  
  f8 f4 f8 |
  bf4 g8 (bf) |
  c4 r8 a16 (bf) |
  g4 g |
  c8 e,4 g8 |
  a4 g |
  f2 \bar "||" \break
  
  ^\markup { \bold \italic "Chọn 1 trong 2 ĐK." }
  f8. f16 f8 d |
  d8. d16 e8 d |
  c2 |
  a'8. g16 f8 f |
  bf8. g16 c8 bf |
  a4 a8 a |
  f4 f8 f |
  g8. c,16 c8 c |
  a'4 bf8 bf |
  g4 g8 g |
  c8. d16 bf8 g |
  f2 \bar "|." \break
  
  a4. g8 |
  f bf4 bf8 |
  c2 |
  g4. bf8 |
  a g4 a8 |
  e2 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  r4 |
  R2*16
  
  f8. f16 f8 d |
  d8. d16 e8 d |
  c2 |
  f8. e16 d8 d |
  g8. e16 a8 g |
  f4 f8 f |
  d4 d8 d |
  b!8. c16 c8 c |
  f4 g8 g |
  e4 d8 c |
  a'8. f16 g8 e |
  f2
  
  f4. e8 |
  d d4 d8 |
  e2 |
  e4. g8 |
  f c4 bf8 |
  a2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Đừng nổi giận vì quân gian ác,
      Chớ phân bì với lũ bất lương,
      chúng như cỏ hoang mau úa,
      như thanh thảo chóng tàn.
      Hãy làm việc thiện và cậy tin ở Chúa,
      Ở lại miền đất mà vui sống yên hàn.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Hãy nín lặng ở tôn nhan Chúa,
	    Ngóng trông Ngài, chớ uất ức chi,
	    dẫu khi gặp quân gian ác
	    luôn thanh thản giữa đời,
	    Nhớ đừng thịnh nộ và đừng căm hận nữa,
	    cũng đừng giận dữ mà vương mắc tội tình.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Quân ác rồi bị tru di hết,
	    Kẻ tôn sợ Chúa đứng vững liên,
	    ác nhân biệt tăm tung tích,
	    nơi xưa chẳng dấu tìm,
	    Kẻ nghèo hèn được Người tặng ban phần đất,
	    sản nghiệp là đây mà vui sống an bình.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Quân ác rình hại người công chính,
	    Chúng căm hờn, tức tối nghiến răng,
	    Chúa trông cười khinh khi chúng,
	    nguy cơ đã sát gần,
	    chúng nhằm hạ người lành bằng gươm nỏ đó,
	    nhưng nỏ gập gẫy, còn gươm thấu tim họ.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Tuy khó nghèo mà luôn công chính
	    Vẫn hơn giầu cứ sống ác ôn,
	    Chúa bang trợ ai công chính,
	    tru di kẻ ác tàn,
	    Trót cuộc đời người lành Ngài luôn gìn giữ,
	    gia nghiệp họ sẽ được kiên vững muôn đời.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
      \override Lyrics.LyricText.font-shape = #'italic
	    Quân ác tàn rồi tiêu vong hết,
	    Cháu con họ khất cái kiếm ăn,
	    biến tan tựa như mây khói,
	    như hoa cỏ giữa đồng.
	    Kẻ lành rộng lượng và cảm thông tặng không,
	    khi mà kẻ dữ mượn đâu có trao hoàn.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "7."
	    Tự thiếu thời rồi cao niên tuế,
	    Chẳng khi nào thấy kiếp chính nhân,
	    cháu con phải đi xin bánh,
	    thân trơ trọi giữa đời.
	    Giống dòng họ rồi được hưởng bao lộc phúc,
	    bởi họ rộng rãi mà cho thiếu cho mượn.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "8."
      \override Lyrics.LyricText.font-shape = #'italic
	    Miệng kẻ lành niệm câu khôn khéo,
	    Lưỡi không ngừng nói lẽ chính trung,
	    khắc ghi luật trong tâm trí,
	    chân đi chẳng xiêu vẹo.
	    Dẫu rằng địch thù thường tìm cơ hạ sát,
	    nhưng họ được Chúa hằng canh giữ an toàn.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "9."
	    Đi đúng đường và trông mong Chúa,
	    Vững tin Người sẽ cất nhắc lên,
	    cứu cho khỏi tay quân dữ,
	    nên gia chủ đất điền,
	    Sẽ được nhìn bọn người tàn hung tuyệt giống,
	    dẫu rằng bọn chúng từng ngạo nghễ khinh đòi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "10."
      \override Lyrics.LyricText.font-shape = #'italic
	    Hãy ngắm nhìn người luôn công chính
	    Sống an hòa lớp lớp cháu con,
	    ác nhân bị tru di hết,
	    quân gian bị tiễu trừ.
	    Chúa bảo vệ người lành khỏi bao cùng khốn,
	    để họ được náu mình luôn mãi bên Ngài.
    }
  >>
  \stanzaReminderOff
  \set stanza = "ĐK 1:"
  Hãy phó thác vận mệnh ở trong tay Ngài.
  Hãy tin cậy vào Chúa, Ngài sẽ ra tay.
  Chính nghĩa bạn tựa bình minh
  Ngài làm rực sáng,
  Phúc đức bạn ngời rạng hơn chính ngọ huy hoàng,
  
  \set stanza = "ĐK 2:"
  Hãy vui mừng luôn trong Chúa,
  Ngài sẽ ban như ước nguyện.
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 3\mm
  bottom-margin = 3\mm
  left-margin = 3\mm
  right-margin = 3\mm
  indent = #0
  #(define fonts
	 (make-pango-font-tree "Deja Vu Serif Condensed"
	 		       "Deja Vu Serif Condensed"
			       "Deja Vu Serif Condensed"
			       (/ 20 20)))
  print-page-number = ##f
  ragged-last-bottom = ##t
  ragged-bottom = ##t
  page-count = 2
}

TongNhip = {
  \key f \major \time 2/4
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
}

\score {
  \new ChoirStaff <<
    \new Staff \with {
        \consists "Merge_rests_engraver"
        printPartCombineTexts = ##f
      }
      <<
      \new Voice \TongNhip \partCombine 
        \nhacPhienKhucSop
        \notBePhu -1 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    \override Lyrics.LyricSpace.minimum-distance = #0.6
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
