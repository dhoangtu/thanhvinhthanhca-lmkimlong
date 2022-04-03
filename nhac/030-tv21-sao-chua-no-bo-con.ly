% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Sao Chúa Nỡ Bỏ Con" }
  composer = "Tv. 21"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \autoPageBreaksOff
  <> \tweak extra-offset #'(-3.5 . -2.7) _\markup { \bold "ĐK:" }
  \partial 4.
  % thêm dấu nghỉ ẩn, vì nốt hoa mỹ ở đầu bản nhạc sẽ bị lỗi
  \once \hide r8
  \slashedGrace { c16 ( } d8) bf |
  a4 \slashedGrace { g16 ( } a8) f |
  e4 r8 e |
  a, \slashedGrace { f'16 ( } e4) cs8 |
  d4 r8 f16 f |
  e8 d g a |
  a4. bf16 bf |
  a8 g c d |
  d4 r8 d |
  d, e16 e f8 d |
  g4. g8 |
  g g16 e e8 g |
  a4 \slashedGrace { cs16 ( } d8) bf |
  a4 \slashedGrace { gs16 ( } a8) f |
  e4 r8 e |
  a, \slashedGrace { f'16 ( } e4) cs8 |
  c2 \bar "||" \break
  
  d8 e c d |
  a4 a8 f' |
  
  \pageBreak
  
  f8. d16 a' (bf) a8 |
  g4 r8 g16 f |
  g8 a g f |
  e4. e8 |
  e8. e16 a8 e |
  d4 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  %\set stanza = "ĐK:"
  Chúa con ơi, Chúa con ơi,
  sao Ngài nỡ bỏ con,
  Cứ đứng xa mà không tiếp cứu,
  Tiếng xiết rên Ngài không đoái tới.
  Suốt ngày than van Chúa chẳng nghe,
  Thâu đêm kêu cầu Ngài không đáp.
  Chúa con ơi, Chúa con ơi sao Ngài nỡ bỏ con.
  <<
    {
      \set stanza = "1."
      Nhưng Chúa ngự nơi đền
      là vinh quang của Is -- ra -- el
      Xưa tổ tiên vẫn trông cậy Ngài
      và Ngài từng đã độ trì.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Ngay lúc rời thai bào
	    Ngài trao tay mẹ ẵm thân con
	    Ngay từ khi mới sinh ra đời
	    đà được phụng hiến cho Ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Khi tứ bề quân thù cùng xông lên
	    ùa đến vây con
	    Nghe mình như nước tan ra dần.
	    ruột mềm tựa sáp tơi bời.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Xin Chúa đừng xa lìa
	    vì con trông nhờ Chúa luôn thôi
	    Xin giựt con thoát nanh muông rừng
	    khỏi miệng đàn chó điên khùng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Con sẽ thuật danh Ngài
	    để anh em từ khắp nơi hay
	    Trong ngày công nhóm
	    con dân Ngài hòa nhịp nhạc khúc ca tụng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
      \override Lyrics.LyricText.font-shape = #'italic
	    Ai kính sợ Chúa Trời cùng ca lên
	    mừng chúc uy danh
	    Chi tộc Gia -- cóp tôn vinh Ngài,
	    phục lạy nào Is -- ra -- el.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "7."
	    Tôi đã chịu ơn Ngài,
	    rầy nơi công hội sẽ ca khen
	    Bao lời đoan hứa xin vuông tròn
	    cận kề kẻ kính sợ Ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "8."
      \override Lyrics.LyricText.font-shape = #'italic
	    Ai khó nghèo cơ cùng được no nê
	    và uống thỏa thuê
	    Ai tìm nhan thánh hãy ca tụng,
	    nguyện họ hạnh phúc muôn đời.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "9."
	    Mau nhớ lại quay về nào con dân từ khắp nơi nơi
	    Muôn ngàn vương quốc trên gian trần
	    cùng phủ phục trước nhan Ngài.
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
  system-system-spacing = #'((basic-distance . 0.1) (padding . 2.5))
  %page-count = #2
  ragged-bottom = ##t
}

TongNhip = {
  \key f \major \time 2/4
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
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
                      (ly:pointer-group-interface::add-grob text
'side-support-elements syllable))
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
% kết thúc mã nguồn

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
