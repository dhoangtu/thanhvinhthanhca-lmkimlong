% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Đặt Niềm Tin Vào Chúa" }
  composer = "Tv. 77"
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
      (padding . 1.0)
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
nhacPhienKhucSop = \relative c'' {
  \autoPageBreaksOff
  \partial 4. b8 g g |
  a e4 fs8 |
  g4 r8 d |
  b'4 c8 a ~ |
  a fs g a |
  d,2 ~ |
  d8 b' g g |
  c b4 c8 |
  d4 r8 b |
  e4 c8 a ~ |
  a a d d |
  g,2 ~ |
  g4 r8 \bar "||" \break
  
  d |
  g4. g16 g |
  g4 \tuplet 3/2 { a8 b g } |
  e4 r8 e |
  c4. \slashedGrace { e16 ( } g8) |
  d4 \tuplet 3/2 { d8 g b } |
  
  \pageBreak
  
  a4 r8 b16 b |
  c8 a d d |
  fs,4. e16 g |
  d8 b d a' |
  g2 ~ |
  g8 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  g8 e e |
  d c4 d8 |
  b4 r8 d |
  g4 e8 c ~ |
  c d e cs |
  d2 ~ |
  d8 g e e |
  a g4 a8 |
  b4 r8 g |
  c4 a8 fs ~ |
  fs d fs fs |
  g2 ~ |
  g4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \stanzaReminderOff
  \set stanza = "ĐK:"
  Hãy đặt niềm tin vào Thiên Chúa,
  và chớ lãng quên kỳ công của Ngài
  Hãy đặt niềm tin vào Thiên Chúa,
  và nhớ tuân hành điều Ngài phán truyền.
  \stanzaReminderOn
  <<
    {
      \set stanza = "1."
      Đừng như cha ông xưa ngoan cố phản loạn,
      tâm địa thất thường, lòng dạ bất trung,
      không tuân giữ giao ước Chúa lập,
      không sống trọn lề luật Chúa ban.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Họ quên bao uy công tay Chúa thể hiện,
	    bao việc vĩ đại họ từng ngắm trông,
	    khi khai lối ngay giữa biển Hồng,
	    đưa dẫn họ lần lượt tiến qua.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Cột mây nơi hoang vu đưa dẫn ban ngày,
	    với cột lửa hồng rạng soi bóng đêm,
	    nơi khe đá khơi suối nước trào
	    cho đã thèm cửa họng khát khô.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Ngài cho mưa man -- na nuôi sống mỗi ngày,
	    bánh thật bởi trời tặng cho thế nhân,
	    xô chim cút sa xuống khắp trại,
	    dân chúng được từng hồi thỏa thuê.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Mà dân luôn vô tâm can mắc thêm tội,
	    các việc Chúa làm họ không muốn tin,
	    nên tay Chúa gom kiếp sống họ,
	    cho tuổi đời thình lình đứt ngang.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
      \override Lyrics.LyricText.font-shape = #'italic
	    Ngài không ngơi yêu thương, không nỡ hủy diệt,
	    nén giận, chẳng đành bừng nộ khí lên,
	    Luôn luôn nhớ thân chúng mỏng dòn,
	    như gió thoảng, ngày về thấy đâu.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "7."
	    Ngài đem Is -- ra -- el lên thánh điện Ngài,
	    tới vùng núi đồi Ngài đã chiếm cho,
	    Đo chia đất đâu đấy có phần,
	    cho mỗi tộc dựng lều trú cư.
    }
  >>
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
  system-system-spacing = #'((basic-distance . 0.1) (padding . 3))
  ragged-bottom = ##t
}

TongNhip = {
  \key g \major \time 2/4
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
    \override Lyrics.LyricSpace.minimum-distance = #1.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
