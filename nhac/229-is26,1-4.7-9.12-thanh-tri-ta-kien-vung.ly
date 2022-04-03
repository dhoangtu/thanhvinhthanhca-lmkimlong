% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Thành Trì Ta Kiên Vững" }
  composer = "Is. 26,1-4.7-9.12"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 4 c8 c |
  d4. e8 |
  f2 ~ |
  f8 f
  <<
    {
      d
    }
    \new Voice = "beSop" {
      \voiceTwo
      \stemDown
      \once \override NoteColumn.force-hshift = #-1.2
      \parenthesize
      e
    }
  >>
  \oneVoice
  d |
  a'4. fs8 |
  g4 r8 e16 e |
  a8 a a b |
  c4. d8 |
  g,4. fs16 g |
  d8 f e d |
  c4 r8 \bar "||" \break
  
  <> \tweak extra-offset #'(-6.5 . -2.5) _\markup { \bold "ĐK:" }
  g' |
  e'4 e8. d16 |
  b8 c c
  \afterGrace a ({
    \override Flag.stroke-style = #"grace"
    g16)}
  \revert Flag.stroke-style
  g4 r8 e |
  e4 f8. d16 |
  d8 g e d |
  c4 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  r4 |
  R2*9
  r4.
  g8 |
  c4 c8. f,16 |
  g8 a a [f] |
  e4 r8 c |
  c4 d8. c16 |
  b8 b b b |
  c4
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Thành trì ta kiên vững,
      Chúa đặt tường lũy chở che.
      Mở cửa ra cho dân công chính tiến vào,
      Một dân tộc nghĩa trung trọn niềm.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Đời đời luôn tin Chúa,
	    Núi \markup { \italic \underline "Đá" }
	    bền vững ngàn năm.
	    Kìa hiền nhân luôn đi theo lối chính trực,
	    Đường kẻ lành Chúa thương san bằng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Chờ đợi luôn nơi Chúa,
	    Lối đường Ngài sẽ vạch ra.
	    Này hồn con miên man thao thức khát vọng,
	    Và luôn tưởng nhớ Tôn Danh Ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Trọn từng đêm thao thức
	    Khát vọng tìm Chúa nào ngơi.
	    Người từ muôn phương tuân theo Chúa phán định,
	    Nhận ra đường lối công minh Ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Này đoàn con xin Chúa
	    Giữ gìn cuộc sống bình an.
	    Mọi việc do tay con dân Chúa đã làm,
	    Nhờ ơn Ngài giúp cho viên thành.
    }
  >>
  %\set stanza = "ĐK:"
  \set stanza = ""
  Ngài quyết giữ dân này an cư lạc nghiệp,
  Vì họ vẫn một lòng vững tin nơi Ngài.
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
  page-count = 1
  system-system-spacing = #'((basic-distance . 0.1) (padding . 3))
}

TongNhip = {
  \key c \major \time 2/4
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
     (padding . 1)
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
