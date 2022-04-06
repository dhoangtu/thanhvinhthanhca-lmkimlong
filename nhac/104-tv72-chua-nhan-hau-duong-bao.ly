% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Chúa Nhân Hậu Dường Bao" }
  composer = "Tv. 72"
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
  c16 (d) c8 g8. bf16 |
  c8 c a16 (c) a8 |
  g4 r8 g16 g |
  f8 f d e16 (d) |
  c2 |
  c8. d16 f8 g |
  e a r c |
  c (a16 g) d8 f |
  g2 ~ |
  g4 bf8 c |
  g8. bf16 d8 c |
  c2 ~ |
  
  \pageBreak
  
  c8 a g c |
  bf g4 e8 |
  f2 ~ |
  f8 \bar "||" \break
  
  c a' f |
  g8. f16 g8 bf |
  c2 ~ |
  c8 c
  \afterGrace a8 [({
    \override Flag.stroke-style = #"grace"
    g16)}
  \revert Flag.stroke-style
  f8] |
  g8. d16 d (f) e (d) |
  c2 ~ |
  c4 f8
  \afterGrace g8 ({
    \override Flag.stroke-style = #"grace"
    f16)}
  \revert Flag.stroke-style
  e8. f16 a (bf) a8 |
  g2 ~ |
  g8 bf bf b! |
  c4 c,8 c |
  g'4. a16 (g) |
  f2 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  R2*15
  r8
  c a' f |
  g8. f16 e8 d |
  e2 ~ |
  e8 e f d |
  c8. b!16 b8 b |
  c2 ~ |
  c4 a8 [bf] |
  c8. c16 f (g) f8 |
  e2 ~ |
  e8 g g f |
  e4 c8 c |
  bf4. c8 |
  a2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Chúa nhân hậu dường bao với Ít -- ra -- en,
      Với những ai tâm hồn trong sạch.
      Vậy mà tôi như hụt bước, chút nữa bị trượt chân,
      Khi ganh tỵ với lũ kiêu căng,
      Khi nhìn ác nhân luôn thịnh đạt.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Chúng không hề gặp tai ương ở trong đời
	    Với tâm thần khỏe mạnh kiêu hùng,
	    mặc người ta bao cực khốn,
	    chúng hững hờ vô can,
	    Luôn đeo kiềng là thói kiêu căng,
	    Đem tàn ác điểm trang toàn thân.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Chúng châm chọc và buông bao tiếng thâm độc,
	    Những tính toan mưu hại hung tàn,
	    miệng ngạo khinh cung trời nữa,
	    tấc lưỡi thực ba hoa,
	    Dân ta hùa theo chúng si mê,
	    Nên lòng chúng say sưa thỏa thuê.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Chúng nhủ rằng: làm sao Chúa thấu tỏ được,
	    Đấng Tối Cao đâu hiểu biết gì.
	    Bọn tàn hung như vậy đó, cứ mãi được an thân,
	    Riêng con này lại luống công sao,
	    Đêm ngày giữ đôi tay sạch tinh.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Tới khi được vào nơi thánh điện của Ngài
	    Mới thấu tri thân phận của họ,
	    Đặt vào nơi trơn trượt đó,
	    Chúa khiến họ tiêu vong,
	    Bao kinh hoàng xua hút tăm hơi,
	    Trong khoảnh khắc tiêu tan còn chi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
      \override Lyrics.LyricText.font-shape = #'italic
	    Chúa xua từ họ đi như thể cơn mơ
	    Đã biến tan khi tỉnh giấc nồng.
	    Này ruột gan con bỏng xót thấy trí mình ngu si,
	    Như trâu ngựa nào có hơn chi
	    Khi Ngài nắm tay con nào ngơi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "7."
	    Chúa khuyên dậy và luôn soi dẫn con đây
	    Tới chốn bao vinh hiển sáng ngời.
	    Còn tìm ai trên trời nữa,
	    dưới đất còn ham chi?
	    Cho thân này rồi có tiêu tan
	    Xin hằng náu nương nơi Ngài liên.
    }
  >>
  \stanzaReminderOff
  \set stanza = "ĐK:"
  Hạnh phúc của con là ở bên Chúa,
  Chốn con tựa nương đặt ở nơi Ngài,
  Ngay cửa vào thành thánh Si -- on,
  con xin loan báo mọi kỳ công của Ngài.
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
  system-system-spacing = #'((basic-distance . 0.1) (padding . 2))
  ragged-bottom = ##t
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
    \override Lyrics.LyricSpace.minimum-distance = #1.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
